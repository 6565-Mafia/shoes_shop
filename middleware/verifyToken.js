//  const jwt = require('jsonwebtoken');
 const User = require('../models/User');
//  const verifyToken =( req,res,next)=>{
//  const authHeader = req.headers.token;
//  if(authHeader){
//  const token=authHeader.split(" ")[1];
//  jwt.verify(token, process.env.JWT_SEC, async (err, user)=>{
//  if(err) res.status(403).json("Invalid token");
//  req.user=user;
//   return next()
//  })
//  }
//  else {
//  return res.status(401).json("you are not authenticated") }
//  }
//   module.exports={verifyToken};
const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {
  const authHeader = req.headers.authorization;
  if (!authHeader) {
    return res.status(401).json({ message: "No token provided" });
  }

  const token = authHeader.split(' ')[1];
  jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: "Failed to authenticate token" });
    }
    req.user = decoded; // Ensure decoded token contains user info
    next();
  });
};

module.exports = {verifyToken};
