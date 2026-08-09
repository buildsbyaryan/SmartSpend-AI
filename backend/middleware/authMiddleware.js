const jwt = require("jsonwebtoken");
const User = require("../models/User");

const protect = async (req, res, next) => {
  try {

    const authHeader = req.headers.authorization;

    // Check token exists
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res.status(401).json({
        success: false,
        message: "Not authorized, token missing",
      });
    }


    // Extract token
    const token = authHeader.split(" ")[1];


    // Verify JWT
    const decoded = jwt.verify(
      token,
      process.env.JWT_SECRET
    );


    // Find user from token id
    const user = await User.findById(decoded.id)
      .select("-password");


    if (!user) {
      return res.status(401).json({
        success: false,
        message: "User not found",
      });
    }


    // Attach user to request
    req.user = user;


    next();

console.log(req.headers.authorization);
  } catch (error) {

    console.log("JWT Error:", error.message);

    if (error.name === "TokenExpiredError") {
      return res.status(401).json({
        success: false,
        message: "Token expired, please login again",
      });
    }


    return res.status(401).json({
      success: false,
      message: "Invalid Token",
    });
  }
};


module.exports = protect;