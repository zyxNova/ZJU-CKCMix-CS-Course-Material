# -*- coding: utf-8 -*-
from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash

from libManage import db

class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20))
    username = db.Column(db.String(20))
    password_hash = db.Column(db.String(128))

    # 获取明文密码的哈希值，用于在数据库中加密
    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    # 验证用户输入的明文密码是否与数据库中的哈希值相对应
    def validate_password(self, password):
        return check_password_hash(self.password_hash, password)

class Book(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(50), nullable=False)
    author = db.Column(db.String(20), nullable=False)
    price = db.Column(db.Float, nullable=False)
    total = db.Column(db.Integer, nullable=False)
    stock = db.Column(db.Integer, nullable=False)
    press = db.Column(db.String(30))
    year = db.Column(db.String(4))
    type = db.Column(db.String(20))

class Card(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(30), nullable=False)
    dept = db.Column(db.String(30))
    update_time = db.Column(db.DateTime, nullable=False)

class Borrow(db.Model):
    card_id = db.Column(db.Integer, db.ForeignKey('card.id'), nullable=False, primary_key=True)
    book_id = db.Column(db.Integer, db.ForeignKey('book.id'), nullable=False, primary_key=True)
    borrow_date = db.Column(db.DateTime, nullable=False)
    return_date = db.Column(db.DateTime, nullable=False)

# 添加书籍
def insertBook(id, title, author, price, total, stock, press, year, type):
    book=Book(id=id, title=title,author=author,price=price, total=total, stock=stock, press=press, year=year, type=type)
    db.session.add(book)
    db.session.commit()

# 添加借书证
def insertCard(id, name, dept, update_time):
    card=Card(id=id, name=name, dept=dept, update_time=update_time)
    db.session.add(card)
    db.session.commit()