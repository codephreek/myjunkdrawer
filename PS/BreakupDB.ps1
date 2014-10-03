param([string]$IFILE="C:/_PowershellScripts/xls/working/Tables2DD.xlsx", 
      [string]$OFILE="C:/_PowershellScripts/xls/working/foo4.xlsx", 
      [int]$ROWNUM=3)


Function CopyRow($WS, $MDS, $WSrow, $MDSrow)
{
    #write-host "Copying data to Sheet: " $WS.name
    $cols = 1
    do{
	$hdr = $MDS.Cells.Item($MDSrow,$cols).Value()
	$WS.Cells.Item($WSrow,$cols) = $hdr
	
	#write-host "copy:  from:"  $MDSrow  ":" , $cols , "  to:" ,$WSrow , ":" $cols

	$cols++
    }while ($hdr -ne $Null)
}

Function AddHeaders($NWS, $MDS)
{
    #write-host "Adding Headers Sheet: " $NWS.name
    $cols = 1
    do{
	$hdr = $MDS.Cells.Item(1,$cols).Value()
	$NWS.Cells.Item(1,$cols) = $hdr
	$cols++
    }while ($hdr -ne $Null)
}

Function CreateNewWorkSheet($WB, $MDS, $SheetIdx, $SheetName)
{
    #write-host "Creating Sheet: " $SheetIdx
    $ActiveWorkSheet = $WB.Worksheets.Item($SheetIdx)
    $ActiveWorkSheet.name = $SheetName
    #write-host "Created Sheet: " $ActiveWorkSheet.name
    AddHeaders -NWS $ActiveWorkSheet -MDS $MDS
    
    #$WB.Worksheets.add([System.Reflection.Missing]::Value,
    #                   $WB.Worksheets.Item($WB.Worksheets.count))

    $ActiveWorkSheet
    return
}

###############################################################
$before = @(Get-Process [e]xcel | %{$_.Id})
$Excel = New-Object -comobject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | ?{$before -notcontains $_}

if( Test-Path -path $IFILE){
    $Excel.Displayalerts = $False
    $WorkBook=$Excel.WorkBooks.Open($IFILE)
    $MainDataSheet = $Workbook.Sheets.Item(1)
    
    $Nwb = $Excel.Workbooks.Add()
    #$Nwb.worksheets.add()
    
    $LastRowUsed = $MainDataSheet.UsedRange.Rows.Count
    
    if($ROWNUM -le 0){
	$ROWNUM = $LastRowUsed
    }
    else{
	$ROWNUM = $ROWNUM
    }
    
    #For each row in the sheet
    $HEADERCOL   = 1
    $STARTINGROW = 2
    $row       = $STARTINGROW
    $trw       = $STARTINGROW
    $sheetIdx  = 1
    $TableName = ""
    $FieldName = ""
    $PreviousTableName = ""
    
    
    clear-host
    #Main Loop
    $CurrentWorkSheet = $Null
    do
    {
	$TableName = $MainDataSheet.Cells.Item($row,$HEADERCOL).Value()
	$FieldName = $MainDataSheet.Cells.Item($row,3).Value()
	if( $TableName -eq $PreviousTableName ){
	    $trw += 1
	    CopyRow  -WS $CurrentWorkSheet -MDS $MainDataSheet -WSrow $trw -MDSrow $row
	}
	else{
	    $CurrentWorkSheet = CreateNewWorkSheet -WB $Nwb -MDS $MainDataSheet -SheetIdx $sheetIdx -SheetName $TableName
	    $f = $Nwb.Worksheets.add([System.Reflection.Missing]::Value,
				     $Nwb.Worksheets.Item($Nwb.Worksheets.count))
	    $sheetIdx++
	    $trw = 2
	    CopyRow  -WS $CurrentWorkSheet -MDS $MainDataSheet -WSrow $trw -MDSrow $row
	}
	
	$percents = [math]::round((($row/$ROWNUM) * 100), 0)
	$txt = "Importing from Excel file - "+ $TableName +":" +$FieldName
	Write-Progress -Activity:$txt -Status:"Imported $row of $ROWNUM total lines ($percents%)" -PercentComplete:$percents
	
	$PreviousTableName = $TableName
	$row++
    }while ($row -le $ROWNUM)
}
else{
    write-host "No Sych File " $IFILE
}

#Close WorkBooks
$Nwb.SaveAs($OFILE)
$Nwb.Close($False)
$Workbook.Close($False) 

$Excel.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)
Remove-Variable -Name Excel
[gc]::collect()
[gc]::WaitForPendingFinalizers()
Stop-Process -Id $ExcelId -Force -ErrorAction SilentlyContinue