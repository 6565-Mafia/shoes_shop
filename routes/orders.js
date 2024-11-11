const router = require('express').Router();
const orderController = require('../controllers/ordersControllers');

const {verifyToken} = require('../middleware/verifyToken');


// Define routes with corresponding controller methods
router.get('/', verifyToken, orderController.getUserOrders);


module.exports = router;