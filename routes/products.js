//const router=require(`express`).Router();
//const productController=require('../controllers/productControllers');
//router.get('/',productController.getAllProducts)
//router.get('/:id',productController.getProducts)  //single product
//router.get('/search/:key',productController.searchProducts)   //for search
//router.get('/',productController.createProducts)
//module.exports=router;

const router = require('express').Router();
const productController = require('../controllers/productsControllers');

// Define routes with corresponding controller methods
router.get('/', productController.getAllProducts); // Get all products
router.get('/:id', productController.getProduct); // Get a single product
router.get('/search/:key', productController.searchProducts); // Search for products
router.post('/', productController.createProduct); // Create a new product

module.exports = router;
