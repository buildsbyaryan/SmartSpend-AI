const express=require("express");

const router=express.Router();


const protect =
require("../middleware/authMiddleware");


const {

monthlyReport,
yearlyReport,
customReport,
categoryReport,
pdfExport,
excelExport

}=require("../controllers/reportController");





// Monthly

router.get(
"/monthly",
protect,
monthlyReport
);



// Yearly

router.get(
"/yearly",
protect,
yearlyReport
);



// Custom Date

router.get(
"/custom",
protect,
customReport
);



// Category

router.get(
"/category",
protect,
categoryReport
);


router.get(
"/pdf",
protect,
pdfExport
);



// Excel Export

router.get(
"/excel",
protect,
excelExport
);



module.exports=router;