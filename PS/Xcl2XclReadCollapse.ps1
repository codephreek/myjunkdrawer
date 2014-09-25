param([string]$IFILE="C:/PowershellScripts/xls/FMITEMHOC.xlsx", 
      [string]$OFILE="C:/PowershellScripts/xls/foo.xlsx", 
      [int]$ROWNUM=3)

$before = @(Get-Process [e]xcel | %{$_.Id})
$Excel = New-Object -comobject Excel.Application
$ExcelId = Get-Process excel | %{$_.Id} | ?{$before -notcontains $_}

#function Release-Ref ($ref) {
#  ([System.Runtime.InteropServices.Marshal]::ReleaseComObject([System.__ComObject]$ref) -gt 0)
##  [System.GC]::Collect()
##  [System.GC]::WaitForPendingFinalizers()
#}

Function WriteCompactLine($Ws, $Sheet, $Wrow, $Rrow, $txt)
{
    $Ws.Cells.Item($Wrow,1) = $Sheet.Cells.Item($Rrow-1,1).Value()
    $Ws.Cells.Item($Wrow,2) = $Sheet.Cells.Item($Rrow-1,2).Value()
    $Ws.Cells.Item($Wrow,3) = $Sheet.Cells.Item($Rrow-1,3).Value()
    $Ws.Cells.Item($Wrow,4) = $Sheet.Cells.Item($Rrow-1,4).Value()
    $Ws.Cells.Item($Wrow,5) = $Sheet.Cells.Item($Rrow-1,5).Value()
    $Ws.Cells.Item($Wrow,6) = $Sheet.Cells.Item($Rrow-1,6).Value()
    $Ws.Cells.Item($Wrow,7) = $Sheet.Cells.Item($Rrow-1,7).Value()
    $Ws.Cells.Item($Wrow,8) = $Sheet.Cells.Item($Rrow-1,8).Value()
    $Ws.Cells.Item($Wrow,9) = $txt
    $Ws.Cells.Item($Wrow,10) = $Sheet.Cells.Item($Rrow-1,10).Value()
    $Ws.Cells.Item($Wrow,11) = $Sheet.Cells.Item($Rrow-1,11).Value()
    #    $Ws.columns.autofit()  
}

Function WriteLine($Ws, $Sheet, $Wrow, $Rrow)
{
    $Ws.Cells.Item($Wrow,1) = $Sheet.Cells.Item($Rrow,1).Value()
    $Ws.Cells.Item($Wrow,2) = $Sheet.Cells.Item($Rrow,2).Value()
    $Ws.Cells.Item($Wrow,3) = $Sheet.Cells.Item($Rrow,3).Value()
    $Ws.Cells.Item($Wrow,4) = $Sheet.Cells.Item($Rrow,4).Value()
    $Ws.Cells.Item($Wrow,5) = $Sheet.Cells.Item($Rrow,5).Value()
    $Ws.Cells.Item($Wrow,6) = $Sheet.Cells.Item($Rrow,6).Value()
    $Ws.Cells.Item($Wrow,7) = $Sheet.Cells.Item($Rrow,7).Value()
    $Ws.Cells.Item($Wrow,8) = $Sheet.Cells.Item($Rrow,8).Value()
    $Ws.Cells.Item($Wrow,9) = $Sheet.Cells.Item($Rrow,9).Value()
    $Ws.Cells.Item($Wrow,10) = $Sheet.Cells.Item($Rrow,10).Value()
    $Ws.Cells.Item($Wrow,11) = $Sheet.Cells.Item($Rrow,11).Value()
    #    $Ws.columns.autofit()
}

Function AppendTxt([string]$Out, [string]$In)
{
    if($Out -eq ""){
	$Out = $In}
    else{
	$Out = $Out + "`r`n"  + $In}
    [string]$Out.Trim()
    return
}

###############################################################
$Excel.Displayalerts = $False
$WorkBook=$Excel.WorkBooks.Open($IFILE)
$Sheet = $Workbook.Sheets.Item(1)

$LastRowUsed = $Sheet.UsedRange.Rows.Count


#For each row in the sheet
$row=2
$col=1

$FormKeyCol = 1
$LineTypeCol = 3
$LiteralTextCol = 9

$PrevFormKey = ""
$CurrFormKey = ""

$PrevLineType = ""
$LineType = ""

$LiteralText = ""
$ConcatText = ""

$NewWorkBook = $Excel.Workbooks.Add()
$ActiveWorkSheet = $NewWorkBook.Worksheets.Item(1)

$NewRow=2

do
{
    $hdr = $Sheet.Cells.Item(1,$col).Value()
    $ActiveWorkSheet.Cells.Item(1,$col) = $hdr
    $col++
}while ($hdr -ne $Null)

if($ROWNUM -lt 0){
    $ROWNUM = $LastRowUsed
}
else{
    $ROWNUM = $ROWNUM
}

clear-host
#Main Loop
$NewRow = 2
$row = 2
$col = 1
$clearhost = 0
$clearhoststr = ""

do
{
    $LineType = $Sheet.Cells.Item($row,$LineTypeCol).Value()
    $CurrFormKey = $Sheet.Cells.Item($row,$FormKeyCol).Value()
    #Reading T type line
    if( $LineType -eq "T" )
    {
	$LiteralText = $Sheet.Cells.Item($row,$LiteralTextCol).Value() 
	$ConcatText = AppendTxt -Out $ConcatText -In $LiteralText
	#	if($ConcatText -eq ""){
	#	    $ConcatText = $LiteralText;}
	#	else{
	#	    $ConcatText = $ConcatText + "`r`n"  + $LiteralText}
	
	#        #First instance
	#        if($PrevFormKey -eq ""){
	#            $LiteralText = $Sheet.Cells.Item($row,$LiteralTextCol).Value() 
	#            if($ConcatText = ""){
	#                $ConcatText = $LiteralText;}
	#            else{
	#                $ConcatText = $ConcatText + "`r`n"  + $LiteralText}
	#        }
	#        else {#Subsequent instances
	#            #Same Form or First Instance of T
	#            if(($PrevFormKey -eq $CurrFormKey)){
	#                $LiteralText = $Sheet.Cells.Item($row,$LiteralTextCol).Value() 
	#                if($ConcatText = ""){
	#                    $ConcatText = $LiteralText;}
	#                else{
	#                    $ConcatText = $ConcatText + "`r`n"  + $LiteralText}
	#            }
	#            #New Form (happened to be back-toback T's
	#            else {
	#                #Not handled now
	#            }
	#        }
    }
    #Was not a T        
    else{
        if(($PrevLineType -eq "T") -and ($ConcatText -ne "")){
	    WriteCompactLine -Ws $ActiveWorkSheet -Sheet $Sheet -Wrow $NewRow -Rrow $row -txt $ConcatText
            $NewRow++
            WriteLine -Ws $ActiveWorkSheet -Sheet $Sheet -Wrow $NewRow -Rrow $row
            $NewRow++
            $ConcatText = ""
        }   
        else{
            WriteLine -Ws $ActiveWorkSheet -Sheet $Sheet -Wrow $NewRow -Rrow $row
            $NewRow++
        }
    }

    $percents = [math]::round((($row/$ROWNUM) * 100), 0)
    Write-Progress -Activity:"Importing from Excel file" -Status:"Imported $row of $ROWNUM total lines ($percents%)" -PercentComplete:$percents

    $PrevLineType = $LineType
    $PrevFormKey = $CurrFormKey
    $row++

}while ($row -le $ROWNUM)

if($ConcatText -ne ""){
    WriteCompactLine -Ws $ActiveWorkSheet -Sheet $Sheet -Wrow $NewRow -Rrow $row -txt $ConcatText
    $NewRow++
    $ConcatText = ""
}   
#clear-host
#Close WorkBooks
$NewWorkBook.SaveAs($OFILE)
$NewWorkBook.Close($False)
$Workbook.Close($False) 

$Excel.Quit()

[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel)
Remove-Variable -Name Excel
[gc]::collect()
[gc]::WaitForPendingFinalizers()
Stop-Process -Id $ExcelId -Force -ErrorAction SilentlyContinue