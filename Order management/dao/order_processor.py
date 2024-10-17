from dao.order_management_repository import IOrderManagementRepository
from exception.usernotfound import UserNotFoundException
from exception.ordernotfound import OrderNotFoundException

class OrderProcessor(IOrderManagementRepository):
    def __init__(self):
        self.users = []
        self.products = []
        self.orders = []

    def create_order(self, user, products):
        if user not in self.users:
            raise UserNotFoundException("User not found.")
        self.orders.append((user, products))

    def cancel_order(self, user_id, order_id):
        if user_id >= len(self.orders):
            raise OrderNotFoundException("Order not found.")
        del self.orders[order_id]

    def create_product(self, user, product):
        if user.role != "Admin":
            raise UserNotFoundException("Only admins can create products.")
        self.products.append(product)

    def create_user(self, user):
        self.users.append(user)

    def get_all_products(self):
        return self.products

    def get_orders_by_user(self, user):
        return [order for order in self.orders if order[0] == user]
