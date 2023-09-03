class ApiEndpoint {
  static const _baseUrl = "http://10.0.2.2:5000/api";

  static const feeds = "dot/feeds";
  static const experts = "dot/stylist";
  static const expertsDetail = "dot/experts/";
  static const area = "dot/locations";
  static const promotion = "dot/promotions";
  static const salonDetail = "dot/salons/";
  static const service = "dot/services/";

  static const productListByCategory = "/products/category/";
  static const productList = "/products/";
  static const productBarCode = "/products/barcode";
  static const scanList = "/scans/";
  static const articleScanList = "/scans/customer/";
  static const categoryList = "/categories/";
  static const productsByCompany = "/products/company/";
  static const storesList = "/stores";
  static const getToken = "/oauth/token";
  static const logout = "/logout";
  static const logout2 = "/logouts";
  static const customer = "/customers/";
  static const customerUser = "/customers/user/";
  static const userEmail = "/users/email/";
  static const address = "/address/";
  static const addressUser = "/addresses/active/";
  static const addressCompany = "/addresses/company/";
  static const updateAddressStatus = "/addresses/update/";

  static const orderList = "/orders/";
  static const orderNew = "/orders/new/";
  static const scanNew = "/scans/new/";
  static const orderUpdate = "/orders/update/";
  static const scanUpdate = "/scans/update/";
  static const newPayment = "/payments/new";
  static const searchTerm = "/products/searchTerm/";
  static const customerOrders = "/orders/customer/";
  static const customerScans = "/scans/customer/";
  static const supplierById = "/suppliers/";
  static const ecoCardExchange = "/ecocard/active/";
  static const companies = "/companies/";
  static const newAddress = "/address/new";
  static const newCreditCard = "/creditcard/new";
  static const newEcoCard = "/eco/new";
  static const creditCards = "/creditcard/user/";
  static const ecoCards = "/ecocard/user/";
  static const newCustomer = "/customer/new";
  static const toggleFavorite = "/products/isFavorite/";
  static const getFavorite = "/products/favorite/";
  static const register = "/register";
  static const sendOtp = "/otp/sendotp/";
  static const verifyOtp = "/otp/verifyotp/";
  static const restPassword = "/user/resetPassWord/";
  static const chargePayment = "/payment/charge";
  static const chargeExchange = "/exchange/charge";
  static const orderItemList = "/orderItems/";
  static const orderItem = "/orderItems/product/";
  static const orderItemNew = "/orderItems/new";

  static const articles = "/articles/";
  static const articleById = "/articles/id/";
  static const articleByScanId = "/articles/scan/";
  static const articleBarCod = "/articles/barcodeNumber/";
  static const articleNew = "/articles/new/";
}
