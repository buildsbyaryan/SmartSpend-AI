const express=require("express");

const router=express.Router();


const protect =
require("../middleware/authMiddleware");


const {

createNotification,

getNotifications,

markRead,

deleteNotification


}=require("../controllers/notificationController");




router.post(
"/",
protect,
createNotification
);



router.get(
"/",
protect,
getNotifications
);



router.put(
"/:id/read",
protect,
markRead
);



router.delete(
"/:id",
protect,
deleteNotification
);



module.exports=router;