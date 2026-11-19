#this blueprint is for the views: Home, Support

from flask import (
    Blueprint, flash, g, redirect, render_template, request, url_for
)

from .auth import login_required
from .db import get_db

bp = Blueprint('home', __name__)

@bp.route('/')
@login_required
def index():
    return render_template('home/index.html')

@bp.route('/support', methods=('GET', 'POST'))
@login_required
def support():
    db = get_db()

    if request.method == 'POST':
        subject = request.form.get('subject', '').strip()
        message = request.form.get('message', '').strip()
        error = None

        if not subject:
            error = 'Subject is required.'
        elif not message:
            error = 'Please describe your issue.'

        if error is None:
            db.execute(
                'INSERT INTO SupportTicket (userId, subject, message, status)'
                ' VALUES (?, ?, ?, ?)',
                (g.user['userId'], subject, message, 'Open'),
            )
            db.commit()
            return redirect(url_for('home.support'))

        flash(error)

    #only show tickets for whoever is logged in, newest first
    tickets = db.execute(
        'SELECT ticketId, subject, message, status FROM SupportTicket'
        ' WHERE userId = ? ORDER BY ticketId DESC',
        (g.user['userId'],),
    ).fetchall()

    return render_template('home/support.html', tickets=tickets)