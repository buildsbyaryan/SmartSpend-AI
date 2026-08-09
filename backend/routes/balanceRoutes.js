const express = require("express");

const router = express.Router();


const protect = require("../middleware/authMiddleware");


const {
    getBalance
}=require("../controllers/balanceController");



router.get(
"/",
protect,
getBalance
);



module.exports = router;