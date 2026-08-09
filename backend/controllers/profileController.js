const User = require("../models/User");
const bcrypt = require("bcryptjs");


// ==========================
// GET PROFILE
// ==========================

exports.getProfile = async (req, res) => {

    try {

        const user = await User.findById(req.user.id)
            .select("-password");


        res.status(200).json({
            success: true,
            user
        });


    } catch (error) {

        res.status(500).json({
            success: false,
            message: error.message
        });

    }

};




// ==========================
// UPDATE PROFILE
// ==========================

exports.updateProfile = async (req, res) => {

    try {

        const {
            name,
            email,
            profileImage,
            monthlyBudget,
            currency,
            notifications
        } = req.body;


        const user = await User.findByIdAndUpdate(

            req.user.id,

            {
                name,
                email,
                profileImage,
                monthlyBudget,
                currency,
                notifications
            },

            {
                new:true,
                runValidators:true
            }

        ).select("-password");



        res.status(200).json({

            success:true,

            message:"Profile updated successfully",

            user

        });



    } catch(error){

        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};





// ==========================
// CHANGE PASSWORD
// ==========================

exports.changePassword = async(req,res)=>{

    try{


        const {
            oldPassword,
            newPassword
        } = req.body;



        const user = await User.findById(req.user.id);



        const isMatch = await bcrypt.compare(
            oldPassword,
            user.password
        );



        if(!isMatch){

            return res.status(400).json({

                success:false,

                message:"Old password is incorrect"

            });

        }



        const hashedPassword =
        await bcrypt.hash(newPassword,10);



        user.password = hashedPassword;


        await user.save();



        res.status(200).json({

            success:true,

            message:"Password changed successfully"

        });



    }catch(error){


        res.status(500).json({

            success:false,

            message:error.message

        });

    }

};






// ==========================
// DELETE ACCOUNT
// ==========================

exports.deleteAccount = async(req,res)=>{


    try{


        await User.findByIdAndDelete(
            req.user.id
        );



        res.status(200).json({

            success:true,

            message:"Account deleted successfully"

        });



    }catch(error){


        res.status(500).json({

            success:false,

            message:error.message

        });


    }

};