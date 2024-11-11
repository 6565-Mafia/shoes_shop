//const User = require('../models/User');
//module.exports={
//
// getUser :async (req, res) => {
//  try {
//    const user = await User.findById(req.user.id);
//    if (!user) {
//      return res.status(404).json({ message: "User not found" });
//    }
//    const { password, __v, updatedAt, createdAt, ...userData } = user._doc;
//    res.status(200).json(userData);
//  } catch (error) {
//    res.status(500).json(error);
//    }},
//
////   getUser:async(req,res) =>{
////try{
////const user =await User.findById(req.user.id)
////const { password, __v, updatedAt, createdAt, ...userData } = user._doc;
////
////
////res.status(200).json(userData)
////} catch (error){
////res.status(500).json(error)
////}
////},
//   userDelete: async (req, res) => {
//    try {
//         await User.findByIdAndDelete(req.user.id)
//        res.status(200).json("User successfully deleted");
//    } catch (err) {
//        res.status(500).json(err);
//    }
//},
//}
const User = require('../models/User');

module.exports = {
  getUser: async (req, res, next) => {
    try {
      const user = await User.findById(req.user.id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      const { password, __v, updatedAt, createdAt, ...userData } = user._doc;
      res.status(200).json(userData);
    } catch (error) {
      next(error); // Pass the error to the error handling middleware
    }
  },

  userDelete: async (req, res, next) => {
    try {
      const user = await User.findById(req.user.id);
      if (!user) {
        return res.status(404).json({ message: "User not found" });
      }
      await User.findByIdAndDelete(req.user.id);
      res.status(200).json("User successfully deleted");
    } catch (err) {
      next(err); // Pass the error to the error handling middleware
    }
  }
};
