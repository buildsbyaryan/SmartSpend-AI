const express = require("express");

const router = express.Router();


const protect = require("../middleware/authMiddleware");


const {

addIncome,

getIncome,

getSingleIncome,

updateIncome,

deleteIncome


} = require("../controllers/incomeController");





router.post(
"/",
protect,
addIncome
);



router.get(
"/",
protect,
getIncome
);



router.get(
"/:id",
protect,
getSingleIncome
);



router.put(
"/:id",
protect,
updateIncome
);



router.delete(
"/:id",
protect,
deleteIncome
);



module.exports = router;