////const Product=require(`../models/Product`);
////module.exports={
////createProduct:async(req,res)=>{
////const newProduct=new Product(req.body)
////try{
////await newProduct.save();
////res.status(200).json("product created")}
////     catch (err){
////     res.status(500).json("product failed to create ")
////     }},
////     getAllProduct:async(req,res)=>{
////     try{
////     const products=await Product.find().sort({created:-1})
////     res.status(200).json(products)}
////
////     }
////     catch(err){
////     res.status(500).json(" failed to get  product ")
////     }
////     },
////     getProduct:async(req,res)=>{
////     const productId=req.params.id
////          try{
////          const product=await Product.findById(productId)
////          const{ _v,createdAt,...productData}= product._doc;
////          res.status(200).json(productData)}
////
////          }
////          catch(err){
////          res.status(500).json(" failed to get  product ")
////          }
////          },
////          searchProduct:async(req,res)=>{
////
////                    try{
////                    const results=await Product.aggregate([
////
////                      {
////                        $search: {
////                          index: "shoes",
////                          text: {
////                            query: req.params.key,
////                            path: {
////                              wildcard: "*"
////                            }
////                          }
////                        }
////                      }
////
////                    ])
////                    res.status(200).json(results)
////                    }
////                    catch(err){
////                    res.status(500).json(" failed to get  product ")
////                    }}
////}
//const Product = require('../models/Product');
//
//module.exports = {
//  createProduct: async (req, res) => {
//    const newProduct = new Product(req.body);
//    try {
//      await newProduct.save();
//      res.status(200).json("Product created");
//    } catch (err) {
//      res.status(500).json("Product failed to create");
//    }
//  },
//
//  getAllProducts: async (req, res) => {
//    try {
//      const products = await Product.find().sort({ created: -1 });
//      res.status(200).json(products);
//    } catch (err) {
//      res.status(500).json("Failed to get products");
//    }
//  },
//
//  getProduct: async (req, res) => {
//    const productId = req.params.id;
//    try {
//      const product = await Product.findById(productId);
//      const { __v, createdAt, ...productData } = product._doc;
//      res.status(200).json(productData);
//    } catch (err) {
//      res.status(500).json("Failed to get product");
//    }
//  },
//
//  searchProducts: async (req, res) => {
//    try {
//      const results = await Product.aggregate([
//        {
//          $search: {
//            index: "shoes",
//            text: {
//              query: req.params.key,
//              path: {
//                wildcard: "*"
//              }
//            }
//          }
//        }
//      ]);
//      res.status(200).json(results);
//    } catch (err) {
//      res.status(500).json("Failed to search products");
//    }
//  }
//};
const Product = require('../models/Product');

module.exports = {
  createProduct: async (req, res) => {
    const newProduct = new Product(req.body);
    try {
      await newProduct.save();
      res.status(200).json("Product created");
    } catch (err) {
      res.status(500).json("Product failed to create");
    }
  },

  getAllProducts: async (req, res) => {
    try {
      const products = await Product.find().sort({ createdAt: -1 });
      console.log('Products found:', products); // Debug log
      res.status(200).json(products);
    } catch (err) {
      console.error('Failed to get products', err); // Debug log
      res.status(500).json("Failed to get products");
    }
  },

  getProduct: async (req, res) => {
    const productId = req.params.id;
    try {
      const product = await Product.findById(productId);
      const { __v, createdAt, ...productData } = product._doc;
      res.status(200).json(productData);
    } catch (err) {
      res.status(500).json("Failed to get product");
    }
  },

  searchProducts: async (req, res) => {
    try {
      const results = await Product.aggregate([
        {
          $search: {
            index: "shoes",
            text: {
              query: req.params.key,
              path: {
                wildcard: "*"
              }
            }
          }
        }
      ]);
      res.status(200).json(results);
    } catch (err) {
      res.status(500).json("Failed to search products");
    }
  }
};
