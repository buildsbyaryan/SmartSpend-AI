const Income = require("../models/Income");
const Expense = require("../models/Expense");


// ===============================
// Get Balance Summary
// ===============================

exports.getBalance = async (req, res) => {

    try {


        const userId = req.user._id;



        // Total Income

        const incomeResult = await Income.aggregate([

            {
                $match:{
                    user:userId
                }
            },

            {
                $group:{
                    _id:null,
                    totalIncome:{
                        $sum:"$amount"
                    }
                }
            }

        ]);




        // Total Expense

        const expenseResult = await Expense.aggregate([

            {
                $match:{
                    user:userId
                }
            },

            {
                $group:{
                    _id:null,
                    totalExpense:{
                        $sum:"$amount"
                    }
                }
            }

        ]);




        const totalIncome =
        incomeResult.length > 0
        ? incomeResult[0].totalIncome
        : 0;



        const totalExpense =
        expenseResult.length > 0
        ? expenseResult[0].totalExpense
        : 0;



        const balance =
        totalIncome - totalExpense;




        res.status(200).json({

            success:true,

            totalIncome,

            totalExpense,

            balance

        });



    }
    catch(error){


        res.status(500).json({

            success:false,

            message:error.message

        });


    }

};