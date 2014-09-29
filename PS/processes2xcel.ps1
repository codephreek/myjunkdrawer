$XL = New-Object -comobject Excel.Application
 
$XL.Visible = $True

$WB = $XL.Workbooks.Add()
$WS = $WB.Worksheets.Item(1)
 
$WS.Cells.Item(1,1) = "ProcessName"
$WS.Cells.Item(1,2) = "Id"
$WS.Cells.item(1,3) = "Handles"
$WS.Cells.item(1,4) = "CPU"
$WS.Cells.item(1,5) = "VM"
 
$counter = 2
 
$processes = get-process
 
foreach($proc in $processes) {
    $WS.cells.item($counter,1) = $proc.ProcessName
    $WS.cells.item($counter,2) = $proc.id
    $WS.cells.item($counter,3) = $proc.Handles
    $WS.cells.item($counter,4) = $proc.CPU
    $WS.cells.item($counter,5) = $proc.VM
    $counter++
}

$WS.columns.autofit()
