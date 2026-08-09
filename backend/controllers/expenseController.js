const Expense = require("../models/Expense");
const Budget = require("../models/Budget");
const Notification = require("../models/Notification");


// ==========================
// Add Expense
// ==========================
exports.addExpense = async(req,res)=>{

try{


const expense = await Expense.create({

user:req.user._id,

title:req.body.title,

amount:req.body.amount,

category:req.body.category,

date:req.body.date || Date.now()

});



// ===============================
// Budget Checking Logic
// ===============================


const budget = await Budget.findOne({

user:req.user._id,

category:req.body.category

});



if(budget){


const expenses =
await Expense.aggregate([

{
$match:{
user:req.user._id,
category:req.body.category
}
},


{
$group:{
_id:null,
total:{
$sum:"$amount"
}
}
}


]);



const totalSpent =
expenses[0]?.total || 0;




// Budget exceeded

if(totalSpent > budget.amount){


await Notification.create({

user:req.user._id,

title:"Budget Exceeded",

message:
`Your ${budget.category} budget limit exceeded`,

type:"budget"

});


}


// 80% warning

else if(totalSpent >= budget.amount*0.8){


await Notification.create({

user:req.user._id,

title:"Budget Alert",

message:
`You have used 80% of your ${budget.category} budget`,

type:"budget"

});


}



}



res.status(201).json({

success:true,

expense

});


}
catch(error){


res.status(500).json({

success:false,

message:error.message

});


}

};



// ==========================
// Get User Expenses
// ==========================
exports.getExpenses = async(req,res)=>{

try{


const expenses = await Expense.find({

user:req.user._id

});


res.json({

success:true,

data:expenses

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};



// ==========================
// Get Single Expense
// ==========================
exports.getSingleExpense = async(req,res)=>{

try{


const expense = await Expense.findOne({

_id:req.params.id,

user:req.user._id

});


res.json({

success:true,

data:expense

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};



// ==========================
// Update Expense
// ==========================
exports.updateExpense = async(req,res)=>{

try{


const expense = await Expense.findOneAndUpdate(

{
_id:req.params.id,
user:req.user._id
},

req.body,

{
new:true
}

);


res.json({

success:true,

data:expense

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};



// ==========================
// Delete Expense
// ==========================
exports.deleteExpense = async(req,res)=>{

try{


await Expense.findOneAndDelete({

_id:req.params.id,

user:req.user._id

});


res.json({

success:true,

message:"Expense Deleted"

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};