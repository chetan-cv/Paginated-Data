# Paginated-Data

A [Flutter](https://flutter.dev/) application using [Django Rest Framework](https://www.django-rest-framework.org/) as Backend.

### It includes:
* A __Paginated API__ created using Django Framework.
* Using this API to load __Paginated data__ into the Flutter App.

### Setup:
```
# Clone the project
git clone https://github.com/chetan-cv/Paginated-Data.git

# setup virtual envrionemnt 

cd Api/
pip install virtualenv
python3 -m virtualenv venv
source venv/bin/activate

# installing packages
pip install -r requirements.txt

# setup backend
cd Api/
python manage.py makemigrations
python manage.py migrate

# create new super user
python manage.py createsuperuser

#run server
python manage.py runserver

# For Flutter
cd AppUI/
# get flutter packages
flutter packages get  OR flutter pub get
# run Flutter project
flutter run
```
