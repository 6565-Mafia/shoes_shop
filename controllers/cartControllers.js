////const Product = require('../models/Product');
////const Cart = require('../models/Cart');
////module.exports={
////addCart:async(req,res)=>{
////const userId=req.user.id;
////const{cartItem, quantity}=req.body;
////try{
////const cart =await Cart.findOne({userId})
////if(cart){
////const existingProduct=cart.products.find(
////(product)=>product.cartItem.toString()==cartItem);
////if(existingProduct){
////existingProduct.quantity+=1}
////else{
////cart.products.push({cartItem,quantity:1})}
////await cart.save();
////res.status(200).json("product added to the cart");
////} else{
////const newCart=new Cart({userId,
////products:[{cartItem,quantity:1}]});
////await newCart.save();
////res.status(200).json("product added to the cart");
////}
////} catch (error){
////res.status(500).json(error);
////}
////},
////getCart:async(req,res)=>{
////const userId=req.user.id;
////try{
//// const cart =await Cart.find({userId});
//// res.status(200).json(cart);
////} catch(error){
////res.status(500).json(error);
////}
////},
//// deleteItem:async(res,req)=>{
//// const cartItemId=req.params.cartItem;
//// try{
//// const updatedCart=await Cart.findOneAndUpdated(
//// {'products._id':cartItemId},
//// {$pull:{products:{_id:cartItemId}}},
//// {new:true});
//// if(!updatedCart){
//// return res.status(404).json({message:"cart item not found"}); }
//// res.status(200).json(updatedCart);
//// } catch (error){
//// res.status(500).json(error);
//// }
//// }
////}
//const Product = require('../models/Product');
//const Cart = require('../models/Cart');
//
//module.exports = {
//  addCart: async (req, res) => {
//    const userId = req.user.id;
//    const { cartItem, quantity } = req.body;
//
//    try {
//      // Check if cartItem exists in the Product collection
//      const productExists = await Product.findById(cartItem);
//      if (!productExists) {
//        return res.status(404).json({ message: "Product not found" });
//      }
//
//      const cart = await Cart.findOne({ userId });
//      if (cart) {
//        const existingProduct = cart.products.find(
//          (product) => product.cartItem.toString() === cartItem
//        );
//
//        if (existingProduct) {
//          existingProduct.quantity += quantity;
//        } else {
//          cart.products.push({ cartItem, quantity: quantity });
//        }
//
//        await cart.save();
//        res.status(200).json("Product added to the cart");
//      } else {
//        const newCart = new Cart({
//          userId,
//          products: [{ cartItem, quantity: quantity }],
//        });
//        await newCart.save();
//        res.status(200).json("Product added to the cart");
//      }
//    } catch (error) {
//      console.error("Error adding product to cart:", error);
//      res.status(500).json({ message: "Internal server error", error: error.message });
//    }
//  },
//
//  getCart: async (req, res) => {
//    const userId = req.user.id;
//
//    try {
//      const cart = await Cart.findOne({ userId }).populate('products.cartItem');
//      res.status(200).json(cart);
//    } catch (error) {
//      console.error("Error getting cart:", error);
//      res.status(500).json({ message: "Internal server error", error: error.message });
//    }
//  },
//
//  deleteItem: async (req, res) => {
//    const cartItemId = req.params.cartItem;
//
//    try {
//      const updatedCart = await Cart.findOneAndUpdate(
//        { 'products._id': cartItemId },
//        { $pull: { products: { _id: cartItemId } } },
//        { new: true }
//      );
//
//      if (!updatedCart) {
//        return res.status(404).json({ message: "Cart item not found" });
//      }
//
//      res.status(200).json(updatedCart);
//    } catch (error) {
//      console.error("Error deleting cart item:", error);
//      res.status(500).json({ message: "Internal server error", error: error.message });
//    }
//  },
//};
const Product = require('../models/Product');
const Cart = require('../models/Cart');

module.exports = {
  addCart: async (req, res) => {
    const userId = req.user.id;
    const { cartItem, quantity } = req.body;
    try {
      let cart = await Cart.findOne({ userId });
      if (cart) {
        // Ensure cart.products is always an array
        if (!cart.products) {
          cart.products = [];
        }
        const existingProduct = cart.products.find(product => product.cartItem.toString() === cartItem);
        if (existingProduct) {
          existingProduct.quantity += quantity;
        } else {
          cart.products.push({ cartItem, quantity });
        }
        await cart.save();
        res.status(200).json("Product added to the cart");
      } else {
        const newCart = new Cart({
          userId,
          products: [{ cartItem, quantity }]
        });
        await newCart.save();
        res.status(200).json("Product added to the cart");
      }
    } catch (error) {
      console.error("Error adding product to cart:", error);
      res.status(500).json("Failed to add product to the cart");
    }
  },

  getCart: async (req, res) => {
    const userId = req.user.id;
    try {
      const cart = await Cart.findOne({ userId }).populate('products.cartItem', "_id name imageUrl price category");
      res.status(200).json(cart);
    } catch (error) {
      res.status(500).json("Failed to get cart");
    }
  },

  deleteCartItem: async (req, res) => {
    const cartItemId = req.params.cartItem;
    try {
      const updatedCart = await Cart.findOneAndUpdate(
        { 'products._id': cartItemId },
        { $pull: { products: { _id: cartItemId } } },
        { new: true }
      );
      if (!updatedCart) {
        return res.status(404).json({ message: "Cart item not found" });
      }
      res.status(200).json(updatedCart);
    } catch (error) {
      res.status(500).json(error);
    }
  }
//  deleteItem: async (req, res) => {
//    const cartItemId = req.params.cartItemId;
//    try {
//      const updatedCart = await Cart.findOneAndUpdate(
//        { 'products._id': cartItemId },
//        { $pull: { products: { _id: cartItemId } } },
//        { new: true }
//      );
//      if (!updatedCart) {
//        return res.status(404).json({ message: "Cart item not found" });
//      }
//      res.status(200).json(updatedCart);
//    } catch (error) {
//      res.status(500).json("Failed to delete cart item");
//    }
//  }
//deleteItem: async (req, res) => {
//  const cartItemId = req.params.cartItemId;
//  try {
//    // Find the cart that contains the product item with the specified ID
//    const cart = await Cart.findOne({ 'products._id': cartItemId });
//
//    if (!cart) {
//      return res.status(404).json({ message: "Cart item not found" });
//    }
//
//    // Remove the product with the specified ID from the products array
//    cart.products = cart.products.filter((product) => product._id.toString() !== cartItemId);
//
//    // Save the updated cart
//    await cart.save();
//
//    res.status(200).json(cart);
//  } catch (error) {
//    console.error("Error while deleting cart item: ", error);
//    res.status(500).json({ message: "Failed to delete cart item" });
//  }
//};

};
