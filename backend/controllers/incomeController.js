const Income = require("../models/Income");


// ==========================
// Add Income
// ==========================

exports.addIncome = async (req,res)=>{

    try{

        const income = await Income.create({

            user:req.user._id,

            title:req.body.title,

            amount:req.body.amount,

            category:req.body.category,

            description:req.body.description,

            paymentMethod:req.body.paymentMethod,

            date:req.body.date

        });


        res.status(201).json({

            success:true,

            message:"Income Added Successfully",

            income

        });


    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};




// ==========================
// Get All Income
// ==========================

exports.getIncome = async(req,res)=>{

    try{


        const incomes = await Income.find({

            user:req.user._id

        }).sort({

            date:-1

        });


        res.json({

            success:true,

            count:incomes.length,

            incomes

        });



    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};





// ==========================
// Get Single Income
// ==========================


exports.getSingleIncome = async(req,res)=>{

    try{


        const income = await Income.findOne({

            _id:req.params.id,

            user:req.user._id

        });


        if(!income){

            return res.status(404).json({

                success:false,

                message:"Income not found"

            });

        }


        res.json({

            success:true,

            income

        });



    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};





// ==========================
// Update Income
// ==========================


exports.updateIncome = async(req,res)=>{

    try{


        const income = await Income.findOneAndUpdate(

            {
                _id:req.params.id,
                user:req.user._id
            },

            req.body,

            {
                new:true
            }

        );


        if(!income){

            return res.status(404).json({

                success:false,

                message:"Income not found"

            });

        }


        res.json({

            success:true,

            message:"Income Updated",

            income

        });



    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};





// ==========================
// Delete Income
// ==========================


exports.deleteIncome = async(req,res)=>{

    try{


        const income = await Income.findOneAndDelete({

            _id:req.params.id,

            user:req.user._id

        });



        if(!income){

            return res.status(404).json({

                success:false,

                message:"Income not found"

            });

        }


        res.json({

            success:true,

            message:"Income Deleted"

        });



    }catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};