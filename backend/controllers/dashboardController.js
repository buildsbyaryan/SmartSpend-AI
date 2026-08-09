const Expense = require("../models/Expense");
const Income = require("../models/Income");


// =================================
// Dashboard API
// =================================

exports.getDashboard = async(req,res)=>{

try{


const userId = req.user._id;



// Total Income

const incomeData =
await Income.aggregate([

{
$match:{
user:userId
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



const totalIncome =
incomeData[0]?.total || 0;




// Total Expense

const expenseData =
await Expense.aggregate([

{
$match:{
user:userId
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



const totalExpense =
expenseData[0]?.total || 0;




// Balance

const balance =
totalIncome - totalExpense;





// Recent Income

const recentIncome =
await Income.find({

user:userId

})
.sort({

createdAt:-1

})
.limit(5);





// Recent Expense

const recentExpense =
await Expense.find({

user:userId

})
.sort({

createdAt:-1

})
.limit(5);






// Chart Data

const chartData =
await Expense.aggregate([

{
$match:{
user:userId
}
},


{
$group:{

_id:"$category",

amount:{
$sum:"$amount"
}

}

}

]);






res.json({

success:true,


dashboard:{


totalIncome,

totalExpense,

balance,


recentTransactions:{

income:recentIncome,

expense:recentExpense

},


chartData


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