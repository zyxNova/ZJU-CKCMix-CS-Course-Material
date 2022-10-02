# -*- coding: utf-8 -*-
import click
import datetime
from libManage import app, db
from libManage.models import User, Book, Card, Borrow, insertBook, insertCard


@app.cli.command()
@click.option('--drop', is_flag=True, help='Create after drop.')
def initdb(drop):
    """Initialize the database."""
    if drop:
        db.drop_all()
    db.create_all()
    click.echo('Initialized database.')


@app.cli.command()
def forge():
    """Generate fake data."""
    db.create_all()

    name = 'Xiong ZiYu'
    books = [
        {'id':1, 'title': 'Think Bayes: Bayesian Statistics In Python', 'author': 'Allen Downey', 'price': 59.0 , 'total':1, 'stock': 1, 'press': 'O\'reilly Media, Inc, Usa', 'year': '2021', 'type':'Python'},
        {'id':2, 'title': 'Data structures and algorithms in Python', 'author': 'Drozdek, Adam', 'price': 40.0, 'total':10, 'stock': 5, 'press': 'Singapore : Cengage Learning Asia Pte Ltd', 'year': '2021', 'type':'DS'}
    ]
    cards = [
        {'id': 1, 'name': 'XiongZiyu', 'dept': 'CKC', 'update_time': datetime.datetime.now()},
        {'id': 2, 'name': 'Jenny', 'dept': 'CS', 'update_time': datetime.datetime.now()}
    ]
    borrows = [
        {'card_id': 1, 'book_id': 1, 'borrow_date': datetime.datetime.now(), \
        'return_date': datetime.datetime.now() + datetime.timedelta(days=40)}
    ]

    user = User(name=name)
    db.session.add(user)
    db.session.commit()
    for b in books:
        insertBook(id=b['id'], title=b['title'], author=b['author'] ,\
        price=b['price'], total=b['total'], stock=b['stock'], \
        press=b['press'], year=b['year'], type=b['type'])
    for c in cards:
        insertCard(id=c['id'], name=c['name'], dept=c['dept'], update_time=c['update_time'])
    for bo in borrows:
        borrow = Borrow(card_id = bo['card_id'], book_id = bo['book_id'],\
        borrow_date = bo['borrow_date'], return_date = bo['return_date'] )
        db.session.add(borrow)
        db.session.commit()
    db.session.close()
    click.echo('Done.')


@app.cli.command()
@click.option('--username', prompt=True, help='The username used to login.')
@click.option('--password', prompt=True, hide_input=True, confirmation_prompt=True, help='The password used to login.')
def admin(username, password):
    """Create user."""
    db.create_all()

    user = User.query.first()
    if user is not None:
        click.echo('Updating user...')
        user.username = username
        user.set_password(password)
    else:
        click.echo('Creating user...')
        user = User(username=username, name='Admin')
        user.set_password(password)
        db.session.add(user)

    db.session.commit()
    click.echo('Done.')