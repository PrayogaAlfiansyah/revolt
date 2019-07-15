from app import create_app, db, migrate, cli
from app.models import User, Post, Message, Notification, Task

app = create_app()
cli.register(app)

@app.shell_context_processor
def make_shell_context():
    return {'db': db, 'User': User, 'Post': Post, 'Message': Message,
    		'Notification': Notification, 'Task': Task}

with app.app_context():
     if db.engine.url.drivername == 'sqlite':
         migrate.init_app(app, db, render_as_batch=True)
     else:
         migrate.init_app(app, db)
