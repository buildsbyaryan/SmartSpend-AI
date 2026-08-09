const Expense = require("../models/Expense");
const Income = require("../models/Income");
const PDFDocument = require("pdfkit");
const ExcelJS = require("exceljs");

// =================================
// Monthly Report
// =================================

exports.monthlyReport = async(req,res)=>{

try{


const {month,year}=req.query;


const startDate =
new Date(year, month-1, 1);


const endDate =
new Date(year, month, 0);



const expenses =
await Expense.find({

user:req.user._id,

date:{
$gte:startDate,
$lte:endDate
}

});



const incomes =
await Income.find({

user:req.user._id,

date:{
$gte:startDate,
$lte:endDate
}

});



const totalExpense =
expenses.reduce(
(sum,item)=>sum+item.amount,
0
);



const totalIncome =
incomes.reduce(
(sum,item)=>sum+item.amount,
0
);



res.json({

success:true,

report:{

month,
year,

totalIncome,

totalExpense,

balance:
totalIncome-totalExpense,

expenses,

incomes

}

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};





// =================================
// Yearly Report
// =================================


exports.yearlyReport = async(req,res)=>{

try{


const year=req.query.year;


const startDate =
new Date(year,0,1);


const endDate =
new Date(year,11,31);



const expenses =
await Expense.find({

user:req.user._id,

date:{
$gte:startDate,
$lte:endDate
}

});



const incomes =
await Income.find({

user:req.user._id,

date:{
$gte:startDate,
$lte:endDate
}

});



const totalExpense =
expenses.reduce(
(sum,item)=>sum+item.amount,
0
);



const totalIncome =
incomes.reduce(
(sum,item)=>sum+item.amount,
0
);



res.json({

success:true,

report:{

year,

totalIncome,

totalExpense,

balance:
totalIncome-totalExpense

}

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};






// =================================
// Custom Date Report
// =================================


exports.customReport = async(req,res)=>{


try{


const {
startDate,
endDate
}=req.query;



const expenses =
await Expense.find({

user:req.user._id,

date:{
$gte:new Date(startDate),
$lte:new Date(endDate)
}

});



const incomes =
await Income.find({

user:req.user._id,

date:{
$gte:new Date(startDate),
$lte:new Date(endDate)
}

});



const totalExpense =
expenses.reduce(
(sum,item)=>sum+item.amount,
0
);



const totalIncome =
incomes.reduce(
(sum,item)=>sum+item.amount,
0
);



res.json({

success:true,

report:{

startDate,

endDate,

totalIncome,

totalExpense,

balance:
totalIncome-totalExpense,

expenses,

incomes

}

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};






// =================================
// Category Wise Expense Report
// =================================


exports.categoryReport = async(req,res)=>{


try{


const data =
await Expense.aggregate([


{
$match:{
user:req.user._id
}
},


{
$group:{

_id:"$category",

total:{
$sum:"$amount"
}

}

},


{
$sort:{
total:-1
}
}


]);



res.json({

success:true,

data

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}
};
// =================================
// PDF Export Report
// =================================

exports.pdfExport = async(req,res)=>{

try{


const expenses =
await Expense.find({

user:req.user._id

});


const incomes =
await Income.find({

user:req.user._id

});



const totalExpense =
expenses.reduce(
(sum,item)=>sum+item.amount,
0
);



const totalIncome =
incomes.reduce(
(sum,item)=>sum+item.amount,
0
);



const doc = new PDFDocument();



res.setHeader(
"Content-Type",
"application/pdf"
);


res.setHeader(
"Content-Disposition",
"attachment; filename=SmartSpend_Report.pdf"
);



doc.pipe(res);



doc.fontSize(22)
.text(
"SmartSpend AI Report",
{
align:"center"
}
);



doc.moveDown();



doc.fontSize(14)
.text(
`Total Income : ₹${totalIncome}`
);


doc.text(
`Total Expense : ₹${totalExpense}`
);


doc.text(
`Balance : ₹${totalIncome-totalExpense}`
);



doc.moveDown();



doc.text(
"Expense Details"
);



expenses.forEach((item)=>{


doc.text(
`${item.category} - ₹${item.amount}`
);


});



doc.moveDown();


doc.text(
"Income Details"
);



incomes.forEach((item)=>{


doc.text(
`${item.source} - ₹${item.amount}`
);


});



doc.end();



}
catch(error){


res.status(500).json({

success:false,

message:error.message

});


}

};

// =================================
// Excel Export Report
// =================================


exports.excelExport = async(req,res)=>{


try{


const workbook =
new ExcelJS.Workbook();



const sheet =
workbook.addWorksheet(
"SmartSpend Report"
);



sheet.columns=[

{
header:"Type",
key:"type",
width:20
},

{
header:"Category",
key:"category",
width:20
},

{
header:"Amount",
key:"amount",
width:15
}

];



const expenses =
await Expense.find({

user:req.user._id

});



const incomes =
await Income.find({

user:req.user._id

});




// Expense Rows

expenses.forEach(item=>{


sheet.addRow({

type:"Expense",

category:item.category,

amount:item.amount

});


});




// Income Rows

incomes.forEach(item=>{


sheet.addRow({

type:"Income",

category:item.source,

amount:item.amount

});


});





res.setHeader(

"Content-Type",

"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

);



res.setHeader(

"Content-Disposition",

"attachment; filename=SmartSpend_Report.xlsx"

);



await workbook.xlsx.write(res);


res.end();


}
catch(error){


res.status(500).json({

success:false,

message:error.message

});


}


};