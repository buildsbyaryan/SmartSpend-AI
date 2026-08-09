const Expense = require("../models/Expense");
const Income = require("../models/Income");


// =================================
// Monthly Income vs Expense
// =================================

exports.monthlyAnalytics = async(req,res)=>{

    try{

        const userId=req.user._id;


        const income = await Income.aggregate([
            {
                $match:{
                    user:userId
                }
            },
            {
                $group:{
                    _id:{
                        month:{
                            $month:"$date"
                        }
                    },
                    total:{
                        $sum:"$amount"
                    }
                }
            }
        ]);


        const expense = await Expense.aggregate([
            {
                $match:{
                    user:userId
                }
            },
            {
                $group:{
                    _id:{
                        month:{
                            $month:"$date"
                        }
                    },
                    total:{
                        $sum:"$amount"
                    }
                }
            }
        ]);


        res.json({

            success:true,

            income,

            expense

        });


    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};



// =================================
// Category Wise Expense
// =================================

exports.categoryExpense = async(req,res)=>{

    try{

        const data = await Expense.aggregate([

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


    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};



// =================================
// Highest Expense Category
// =================================

exports.highestCategory = async(req,res)=>{

    try{


        const result = await Expense.aggregate([

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
            },

            {
                $limit:1
            }

        ]);



        res.json({

            success:true,

            highest: result[0] || null

        });


    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};




// =================================
// Saving Percentage
// =================================

exports.savingPercentage = async(req,res)=>{


try{


const income = await Income.aggregate([

{
$match:{
user:req.user._id
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



const expense = await Expense.aggregate([

{
$match:{
user:req.user._id
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
income[0]?.total || 0;


const totalExpense =
expense[0]?.total || 0;



const saving =
totalIncome-totalExpense;



const percentage =
totalIncome===0
?0
:(saving/totalIncome)*100;



res.json({

success:true,

saving,

percentage:percentage.toFixed(2)

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
// Date Range Analytics
// =================================

exports.dateAnalytics = async(req,res)=>{


try{


const {startDate,endDate}=req.query;


const expenses = await Expense.find({

user:req.user._id,

date:{
$gte:new Date(startDate),
$lte:new Date(endDate)
}

});



const incomes = await Income.find({

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

data:{

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