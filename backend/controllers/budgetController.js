const Budget = require("../models/Budget");


// ================================
// Add Budget
// ================================

exports.addBudget = async(req,res)=>{

try{


const budget = await Budget.create({

user:req.user._id,

category:req.body.category,

limit:req.body.limit,

month:req.body.month,

year:req.body.year

});


res.status(201).json({

success:true,

message:"Budget Added Successfully",

budget

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};


// ================================
// Get All Budgets
// ================================


exports.getBudgets = async(req,res)=>{

try{


const budgets =
await Budget.find({

user:req.user._id

});


res.json({

success:true,

budgets

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};






// ================================
// Update Budget
// ================================


exports.updateBudget = async(req,res)=>{

try{


const budget =
await Budget.findOneAndUpdate(

{
_id:req.params.id,
user:req.user._id
},

req.body,

{
new:true
}

);



if(!budget){

return res.status(404).json({

success:false,

message:"Budget not found"

});

}



res.json({

success:true,

budget

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};







// ================================
// Delete Budget
// ================================


exports.deleteBudget = async(req,res)=>{

try{


const budget =
await Budget.findOneAndDelete({

_id:req.params.id,

user:req.user._id

});



if(!budget){

return res.status(404).json({

success:false,

message:"Budget not found"

});

}



res.json({

success:true,

message:"Budget deleted"

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}


};

// ================================
// Budget Limit Checking
// ================================

exports.checkBudget = async(req,res)=>{

try{


const {
category,
month,
year
}=req.query;



const budget =
await Budget.findOne({

user:req.user._id,

category,

month,

year

});



if(!budget){

return res.json({

success:true,

message:"No budget found",

exceeded:false

});

}



res.json({

success:true,

budget,

exceeded:false

});


}
catch(error){

res.status(500).json({

success:false,

message:error.message

});

}

};