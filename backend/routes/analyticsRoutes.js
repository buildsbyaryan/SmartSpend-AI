const express=require("express");

const router=express.Router();

const protect=require("../middleware/authMiddleware");


const {
dateAnalytics
}=require("../controllers/analyticsController");



router.get(
"/date",
protect,
dateAnalytics
);



module.exports=router;