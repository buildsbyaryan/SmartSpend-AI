const dotenv = require("dotenv");
dotenv.config();

const connectDB = require("./config/db");
const app = require("./app");

const PORT = process.env.PORT || 5000;


connectDB()
.then(()=>{

 app.listen(PORT,"0.0.0.0",()=>{
   console.log(`🚀 Server running on port ${PORT}`);
 });

})
.catch((err)=>{
 console.log("DB ERROR:",err);
});