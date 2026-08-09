const express = require("express");

const router = express.Router();

const protect = require("../middleware/authMiddleware");


const {

addExpense,

getExpenses,

getSingleExpense,

updateExpense,

deleteExpense

}=require("../controllers/expenseController");



router.post(
"/",
protect,
addExpense
);


router.get(
"/",
protect,
getExpenses
);


router.get(
"/:id",
protect,
getSingleExpense
);


router.put(
"/:id",
protect,
updateExpense
);


router.delete(
"/:id",
protect,
deleteExpense
);



module.exports = router;