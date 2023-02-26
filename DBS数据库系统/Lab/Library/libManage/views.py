# -*- coding: utf-8 -*-
from flask import render_template, request, url_for, redirect, flash
from flask_login import login_user, login_required, logout_user, current_user
import datetime
from libManage import app, db
from libManage.models import User, Book, Card, Borrow, insertBook, insertCard
from sqlalchemy import desc
from xlrd import open_workbook

@app.route('/', methods=['GET', 'POST'])
def index(**sort_by):
    order = request.args.get('sort_by')
    sort_way = request.args.get('sort_way')
    print(order)
    if not sort_way:
        books = Book.query.order_by(desc(order)).all()
    else:
        books = Book.query.order_by(order).all()
    if request.method == 'POST':
        title = request.form['title']
        author = request.form['author']
        price_low = request.form['price_low']
        price_high = request.form['price_high']
        have_stock = request.form['stock']
        print("have_stock:", have_stock)
        press = request.form['press']
        year_start = request.form['year_start']
        year_end = request.form['year_end']
        type = request.form['type']

        if not title and not author and not price_low and not price_high\
            and have_stock == '0' and not press and not year_start and not year_end and not type:
            flash('Invalid input.')
            return redirect(url_for('index'))
        
        conditions = []
        if title:
            conditions.append(Book.title == title)
        if author:
            conditions.append(Book.author == author)
        if price_low:
            conditions.append(Book.price >= price_low)
        if price_high:
            conditions.append(Book.price <= price_high)
        if press:
            conditions.append(Book.press == press)
        if year_start:
            conditions.append(Book.year >= year_start)
        if year_end:
            conditions.append(Book.year <= year_end)
        if type:
            conditions.append(Book.type == type)
        if have_stock == '1':
            conditions.append(Book.stock > 0)

        books = db.session.query(Book).filter(*conditions).all()

    return render_template('index.html', books=books)

@app.route('/bookManage', methods=['GET', 'POST'])
def bookManage():
    if request.method == 'POST':
        id = request.form['id']
        title = request.form['title']
        author = request.form['author']
        price = request.form['price']
        total = request.form['total']
        stock = request.form['stock']
        press = request.form['press']
        year = request.form['year']
        type = request.form['type']

        if not id or not title or not author\
            or not price or not total or\
            not stock or not press\
            or not year or not type:
            flash('Invalid input. Every Attribute needs to be non-empty.')
            return redirect(url_for('bookManage'))
        total = int(total)
        stock = int(stock)
        if total < 0 or stock < 0:
            flash('Invalid input. Total and Stock must be positive integer.')
            return redirect(url_for('bookManage'))
        if total < stock:
            flash('Invalid input. Total must be equal or greater than Stock.')
            return redirect(url_for('bookManage'))
            
        checkID = db.session.query(Book).filter(Book.id == id).all()
        if checkID:
            flash('Invalid input. Book ID is duplicated.')
            return redirect(url_for('bookManage'))
        if len(year) != 4:
            flash('Invalid input. Length of Year should be 4.')
            return redirect(url_for('bookManage'))
        insertBook(id, title, author, price, total, stock, press, year, type)
        flash('Book added.')
        return redirect(url_for('bookManage'))

    books = Book.query.all()
    return render_template('bookManage.html', books=books)

@app.route('/bookManage/delete/<int:book_id>', methods=['GET'])
@login_required
def deleteBook(book_id):
    book = Book.query.get_or_404(book_id)
    borrow = db.session.query(Borrow).filter(Borrow.book_id == book_id).all()
    if borrow:
        for brow in borrow:
            db.session.delete(brow)
    db.session.delete(book)
    db.session.commit()
    flash('Book deleted.')
    return redirect(url_for('bookManage'))

@app.route('/addExcel',methods = ['POST'])
def addExcel():
    if request.method == 'POST':
        file = request.files.get('file')
        f = file.read()
        if not f:
            flash('File cannot open. Please upload a .xls file.')
            return redirect('/bookManage')
        clinic_file = open_workbook(file_contents=f)
        # sheet1
        table = clinic_file.sheet_by_index(0)
        nrows = table.nrows
        for i in range(1, nrows):
            book = Book()
            row_date = table.row_values(i)
            print(row_date)
            if row_date[0]:
                book.id = int(row_date[0]);
            else:
                flash('Row %d: Invalid input. Book ID cannot be empty.' % i)
                continue
            if row_date[1]:
                book.title = str(row_date[1]);
            else:
                flash('Row %d: Invalid input. Title cannot be empty.' % i)
                continue
            if row_date[2]:
                book.author = str(row_date[2]);
            else:
                flash('Row %d: Invalid input. Author cannot be empty.' % i)
                continue
            if row_date[3]:
                book.price = float(row_date[3]);
            else:
                flash('Row %d: Invalid input. Price cannot be empty.' % i)
                continue
            if row_date[4]:
                book.total = int(row_date[4]);
            else:
                flash('Row %d: Invalid input. Total cannot be empty.' % i)
                continue
            if row_date[5]:
                book.stock = int(row_date[5]);
            else:
                flash('Row %d: Invalid input. Stock cannot be empty.' % i)
                continue
            if row_date[6]:
                book.press = str(row_date[6]);
            else:
                flash('Row %d: Invalid input. Press cannot be empty.' % i)
                continue
            if row_date[7]:
                book.year = str(int(row_date[7]));
                if len(book.year) != 4:
                    flash('Row %d: Invalid input. Length of Year should be 4.' % i)
                    continue
            else:
                flash('Row %d: Invalid input. Year cannot be empty.' % i)
                continue
            if row_date[8]:
                book.type = str(row_date[8]);
            else:
                flash('Row %d: Invalid input. Type cannot be empty.' % i)
                continue
            checkID = db.session.query(Book).filter(Book.id == book.id).all()
            if checkID:
                flash('Row %d: Invalid input. Book ID %d is duplicated.' % (i, book.id))
                continue
            db.session.add(book)
        db.session.commit()
        db.session.close()            
        return redirect('/bookManage')


@app.route('/cardManage', methods=['GET', 'POST'])
@login_required
def cardManage():
    if request.method == 'POST':
        id = request.form['id']
        name = request.form['name']
        dept = request.form['dept']
        update_time = datetime.datetime.now()

        if not id or not dept or not name:
            flash('Invalid input. Every Attribute needs to be non-empty.')
            return redirect(url_for('cardManage'))
        checkID = db.session.query(Card).filter(Card.id == id).all()
        if checkID:
            flash('Invalid input. Card ID %d is duplicated.' % int(id))
            return redirect(url_for('cardManage'))
        insertCard(id, name, dept, update_time)
        flash('Card added.')
        return redirect(url_for('cardManage'))

    cards = Card.query.all()
    return render_template('cardManage.html', cards=cards)


@app.route('/cardManage/edit/<int:card_id>', methods=['GET', 'POST'])
@login_required
def edit(card_id):
    card = Card.query.get_or_404(card_id)

    if request.method == 'POST':
        name = request.form['name']
        dept = request.form['dept']

        if not name or not dept:
            flash('Invalid input. Every Attribute needs to be non-empty.')
            return redirect(url_for('edit', card_id = card_id))

        if name:
            card.name = name
        if dept:
            card.dept = dept
        db.session.commit()
        flash('Card Information updated.')
        return redirect(url_for('cardManage'))
    return render_template('edit.html', card=card)


@app.route('/cardManage/delete/<int:card_id>', methods=['GET'])
@login_required
def delete(card_id):
    card = Card.query.get_or_404(card_id)
    borrow = db.session.query(Borrow).filter(Borrow.card_id == card_id).all()
    if borrow:
        for brow in borrow:
            db.session.delete(brow)
    db.session.delete(card)
    db.session.commit()
    flash('Card deleted.')
    return redirect(url_for('cardManage'))


@app.route('/borrow', methods=['GET', 'POST'])
@login_required
def borrow():
    borrows = db.session.query(Book.id.label('book_id'),Book.title,\
            Book.author, Borrow.card_id.label('card_id'), Borrow.borrow_date, \
            Borrow.return_date) \
            .join(Borrow, Book.id == Borrow.book_id).all()
    card_id = None
    if request.method == 'POST':
        cid = request.form['cid']
        bid = request.form['bid']
        if cid:
            card_id = cid
            borrows = db.session.query(Book.id.label('book_id'),Book.title,\
            Book.author, Borrow.card_id.label('card_id'), Borrow.borrow_date, \
            Borrow.return_date) \
            .join(Borrow, Book.id == Borrow.book_id) \
            .filter(Borrow.card_id == cid).all()
        if not cid and not bid:
            flash('Invalid input.')
            return redirect(url_for('borrow'))
        if not card_id and bid:
            flash('Input Card ID first.')
            return redirect(url_for('borrow'))
        if card_id and bid:
            ret_card = db.session.query(Card).filter(Card.id == cid).first()
            if not ret_card:
                flash('Card ID doesn\'t exist.')
                return redirect(url_for('borrow'))
            ret_book = db.session.query(Book).filter(Book.id == bid).first()
            if not ret_book:
                flash('Book ID doesn\'t exist.')
                return redirect(url_for('borrow'))
            if ret_book.stock <= 0:
                flash('The Book is out of stock.')
                return redirect(url_for('borrow'))

            borrow_date = datetime.datetime.now()
            delta = datetime.timedelta(days=40)
            return_date = borrow_date + delta
            borrow=Borrow(card_id=card_id, book_id=ret_book.id, borrow_date=borrow_date, return_date=return_date)
            db.session.add(borrow)

            ret_book.stock = ret_book.stock - 1;
            db.session.commit()
            flash('Book borrowed.')
            return redirect(url_for('borrow'))
        
    return render_template('borrow.html', borrows=borrows)

@app.route('/returnBook/<int:book_id>/<int:card_id>', methods=['GET', 'POST'])
@login_required
def returnBook(book_id, card_id):
    if card_id and book_id:
        borrow = db.session.query(Borrow).filter(Borrow.card_id==card_id, Borrow.book_id==book_id).first()
        db.session.delete(borrow)
        book = Book.query.get_or_404(book_id)
        book.stock = book.stock + 1
        db.session.commit()
        flash('Book returned.')
    return redirect(url_for('borrow'))
    

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        if not username or not password:
            flash('Invalid input.')
            return redirect(url_for('login'))

        user = User.query.first()

        if username == user.username and user.validate_password(password):
            login_user(user)
            flash('Login success.')
            return redirect(url_for('index'))

        flash('Invalid username or password.')
        return redirect(url_for('login'))

    return render_template('login.html')


@app.route('/logout')
@login_required
def logout():
    logout_user()
    flash('Goodbye.')
    return redirect(url_for('index'))