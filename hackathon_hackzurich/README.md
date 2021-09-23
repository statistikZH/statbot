# Run the database and the notebooks locally

You can run the database and the notebooks locally using docker-compose by doing the following:

1. Run `docker-compose up` to start the containers
2. Run `docker-compose exec postgres sh -c 'psql --dbname=hack_zurich --username=hack_zurich --password < /var/dumps/hack_zurich.sql'` to create the database
3. Run `jupyter notebook` to start the notebook server
4. Open your browser at <http://localhost:8888/tree> and open the [`update_database_from_csv.ipynb`](./update_database_from_csv) notebook
5. Follow the instructions in the notebook and run the cells progressively

If you update data (ie. add data to CSV files), just run the notebook again to add the new data.
