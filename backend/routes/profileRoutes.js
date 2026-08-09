const express = require("express");

const router = express.Router();


const protect = require("../middleware/authMiddleware");


const {
getProfile,
updateProfile,
changePassword,
deleteAccount

}=require("../controllers/profileController");



// Protected Routes

router.get(
"/",
protect,
getProfile
);


router.put(
"/update",
protect,
updateProfile
);



router.put(
"/change-password",
protect,
changePassword
);



router.delete(
"/delete",
protect,
deleteAccount
);



module.exports = router;