const ExcelJS = require("exceljs");



exports.generateExcel = async(data)=>{


const workbook =
new ExcelJS.Workbook();


const sheet =
workbook.addWorksheet(
"Expense Report"
);



sheet.columns=[

{
header:"Title",
key:"title"
},

{
header:"Amount",
key:"amount"
},

{
header:"Category",
key:"category"
},

{
header:"Date",
key:"date"
}

];



data.forEach(item=>{

sheet.addRow(item);

});



return await workbook.xlsx.writeBuffer();


};