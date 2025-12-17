/**
 * @file actions/index.ts
 * @description Server Actions 진입점
 */

// 상품 관련
export {
  getProducts,
  getFeaturedProducts,
  getProductBySlug,
  getProductById,
  incrementViewCount,
  getRelatedProducts,
  getNewProducts,
  createProduct,
  updateProduct,
  deleteProduct,
} from './products';

// 카테고리 관련
export {
  getCategories,
  getCategoryBySlug,
  getCategoriesWithProductCount,
} from './categories';

// 리뷰 관련
export {
  getExternalReviews,
  getUserReviews,
  createUserReview,
  updateUserReview,
  deleteUserReview,
  voteReviewHelpful,
  getMyReviews,
} from './reviews';

// 위시리스트 관련
export {
  getWishlist,
  addToWishlist,
  removeFromWishlist,
  toggleWishlist,
  isInWishlist,
} from './wishlists';

// 럭키드로우 관련
export {
  getActiveLuckyDrawEvent,
  getAllLuckyDrawEvents,
} from './lucky-draw';

// 장바구니 관련
export {
  getCartItems,
  getCartCount,
  addToCart,
  updateCartQuantity,
  removeFromCart,
  clearCart,
  isInCart,
  getCartTotal,
} from './cart';

// 주문 관련
export {
  getMyOrders,
  getOrderDetail,
  getOrderByNumber,
  cancelOrder,
  getOrderCounts,
} from './orders';

