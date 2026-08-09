const Expense = require("../models/Expense");
const Income = require("../models/Income");


// =====================================
// Generate Smart Insights
// =====================================

exports.getInsights = async(req,res)=>{

    try{

        const userId = req.user._id;



        // Total Income

        const incomeData = await Income.aggregate([

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

        const expenseData = await Expense.aggregate([

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
        incomeData[0]?.totalIncome || 0;


        const totalExpense =
        expenseData[0]?.totalExpense || 0;



        const saving =
        totalIncome-totalExpense;



        let healthScore=0;


        if(totalIncome>0){

            healthScore =
            ((saving/totalIncome)*100)
            .toFixed(0);

        }




        // Category Analysis


        const category = await Expense.aggregate([

            {
                $match:{
                    user:userId
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



        let tips=[];



        // Saving Tips


        if(totalExpense > totalIncome){

            tips.push(
                "Your expenses are higher than income. Reduce unnecessary spending."
            );

        }


        else if(
            totalExpense > totalIncome*0.8
        ){

            tips.push(
                "You are spending more than 80% of your income. Try saving more."
            );

        }


        else{

            tips.push(
                "Great! Your spending is under control."
            );

        }




        // Category Warning


        if(category.length>0){

            tips.push(
                `Your highest spending category is ${category[0]._id}.`
            );

        }



        // Saving Suggestion


        if(saving>0){

            tips.push(
                `You can save ₹${saving} this month.`
            );

        }



        res.json({

            success:true,

            financialHealthScore:healthScore,

            totalIncome,

            totalExpense,

            saving,

            highestExpenseCategory:
            category[0] || null,


            suggestions:tips


        });



    }
    catch(error){


        res.status(500).json({

            success:false,

            message:error.message

        });


    }

};