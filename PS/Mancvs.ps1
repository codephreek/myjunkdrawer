param([string]$IFILE="C:\PowershellScripts\xls\FMITEMHOC.xlsx", [string]$OFILE="C:\PowershellScripts\xls\foo.csv", [int]$ROWNUM=1)

$before = @(Get-Process [e]xcel | %{$_.Id})
$Excel = New-Object -comobject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | ?{$before -notcontains $_}

#function Release-Ref ($ref) {
#  ([System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$ref) -gt 0)
##  [System.GC]::Collect()
##  [System.GC]::WaitForPendingFinalizers()
#}

#################################################################
Function WriteCompactLine($Ws, $obj, $Wrow, $txt)
{
    $line = ""
    $line += $obj.formkey + ","
    $line += $obj.seqno   + ","
    $line += $obj.linetyp + ","
    $line += $obj.itemkey + ","
    $line += $obj.location + ","
    $line += $obj.wtorunitqty + ","
    $line += $obj.usewtvolalt + ","
    $line += $obj.ovrhdkey + ","
    $line += $txt + ","
    $line += $obj.loss + ","
    $line += $obj.spare + ","
    
    Add-Content $Ws $line
}

################################################################# 
Function WriteLine($Ws, $obj, $Wrow)
{
    $line = ""
    $line += $obj.formkey + ","
    $line += $obj.seqno   + ","
    $line += $obj.linetyp + ","
    $line += $obj.itemkey + ","
    $line += $obj.location + ","
    $line += $obj.wtorunitqty + ","
    $line += $obj.usewtvolalt + ","
    $line += $obj.ovrhdkey + ","
    $line += $obj.literaltext + ","
    $line += $obj.loss + ","
    $line += $obj.spare + ","
    
    Add-Content $Ws $line
}

#################################################################
Function AppendTxt([string]$Out, [string]$In)
{
    if($Out -eq ""){
	$Out = $In}
    else{
	$Out = $Out + "`r"  + $In}
    [string]$Out.Trim()
    return
}

#################################################################
#write-host $OFILE
#if(($OFILE -ne "-h") -and ($IFILE -ne "-h") -and ($ROWNUM -ne "-h")){
    if(Test-Path -path $IFILE) {
	$Dir = Get-ChildItem $IFILE
	$Dir = $Dir.DirectoryName
	$csvFile = ($Dir + "/" +((Get-Item -path $IFILE).name).Replace(((Get-Item -path $IFILE).extension),".csv"))
	# Open an Excel instance
	$Excel.Displayalerts = $False
	# Open the Master Excel workbook
	$MasterWorkBook=$Excel.WorkBooks.Open($IFILE)
	$Sheet = $MasterWorkbook.Sheets.Item(1)
	$LastRowUsed = $Sheet.UsedRange.Rows.Count
	# Save the Master Excel workbook as a csv file for faster processing
	$MasterWorkBook.SaveAs($csvFile,6)
	# Clean up and close Mster workbook
	$MasterWorkBook.close()
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($MasterWorkBook) | Out-Null
	
	# Import csv file
	$csvdata = Import-Csv -path $csvFile

	if($ROWNUM -lt 0){
	    $ROWNUM = $LastRowUsed
	}
	else{
	    $ROWNUM = $ROWNUM
	}
	
	$outputscv   = $OFILE
	$LineType    = ""
	$LiteralText = ""
	$ConcatText  = ""
	$PrevLineType= ""
	$row    = 0
	$NewRow = 2
	$pobj   = $Null
	
	clear-host

	ForEach ( $obj in $csvData ){
	    if( $row -ge $ROWNUM ){
		break}
	    
	    $row++
	    
	    $percents = [math]::round((($row/$ROWNUM) * 100), 0)
	    Write-Progress -Activity:"Importing from Excel file" -Status:"Imported $row of $ROWNUM total lines ($percents%)" -PercentComplete:$percents

	    

	    $LineType = $obj.linetyp
	    #Reading T type line
	    if( $LineType -eq "T" )
	    {
		$LiteralText = $obj.literaltext
		$ConcatText = AppendTxt -Out $ConcatText -In $LiteralText
	    }
	    #Was not a T        
	    else{
		if(($PrevLineType -eq "T") -and ($ConcatText -ne "")){
   		    WriteCompactLine -Ws $outputscv -obj $pobj -Wrow $NewRow -txt $ConcatText
		    $NewRow++
		    WriteLine -Ws $outputscv -obj $obj -Wrow $NewRow
		    $NewRow++
		    $ConcatText = ""
		}   
		else{
		    WriteLine -Ws $outputscv -obj $obj -Wrow $NewRow
		    $NewRow++
		}
	    }
	    $pobj = $obj
	    $PrevLineType = $LineType
	}
	
	if($ConcatText -ne ""){
	    WriteCompactLine -Ws $outputscv -obj $pobj -Wrow $NewRow -txt $ConcatText
	    $ConcatText = ""
	}   
	
	$Excel.Quit()
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel) | Out-Null
	Remove-Variable -Name Excel
	[gc]::collect()
	[gc]::WaitForPendingFinalizers()
	Stop-Process -Id $ExcelId -Force -ErrorAction SilentlyContinue
    }
    else{
	write-error "An Error has occured"
    }