const Notification = require("../models/Notification");



// =================================
// Create Notification
// =================================

exports.createNotification = async(req,res)=>{


    try{


        const notification =
        await Notification.create({

            user:req.user._id,

            title:req.body.title,

            message:req.body.message,

            type:req.body.type

        });



        res.status(201).json({

            success:true,

            notification

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
// Get User Notifications
// =================================


exports.getNotifications = async(req,res)=>{


    try{


        const notifications =
        await Notification.find({

            user:req.user._id

        })
        .sort({
            createdAt:-1
        });



        res.json({

            success:true,

            count:notifications.length,

            notifications

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
// Mark Notification Read
// =================================


exports.markRead = async(req,res)=>{


    try{


        const notification =
        await Notification.findOneAndUpdate(

            {
                _id:req.params.id,

                user:req.user._id
            },


            {
                isRead:true
            },


            {
                new:true
            }

        );



        if(!notification){

            return res.status(404).json({

                success:false,

                message:"Notification not found"

            });

        }



        res.json({

            success:true,

            notification

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
// Delete Notification
// =================================


exports.deleteNotification = async(req,res)=>{


    try{


        const notification =
        await Notification.findOneAndDelete({

            _id:req.params.id,

            user:req.user._id

        });



        if(!notification){

            return res.status(404).json({

                success:false,

                message:"Notification not found"

            });

        }



        res.json({

            success:true,

            message:"Notification Deleted"

        });



    }
    catch(error){


        res.status(500).json({

            success:false,

            message:error.message

        });


    }

};