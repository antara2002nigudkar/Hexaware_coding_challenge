from Entity.user import User
from Entity.product import Product
from exception.usernotfound import UserNotFoundException
from exception.ordernotfound import OrderNotFoundException

class IOrderManagementRepository:
    def create_order(self, user, products):
        pass

    def cancel_order(self, user_id, order_id):
        pass

    def create_product(self, user, product):
        pass

    def create_user(self, user):
        pass

    def get_all_products(self):
        pass

    def get_orders_by_user(self, user):
        pass
