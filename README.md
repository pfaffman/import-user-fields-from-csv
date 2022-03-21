## Import Discourse Custom User fields from CSV file

Create a CSV file with column names in the first row.

One column must contain the `user_id` (not `username`). Custom user fields have internal names like `user_field_1`, so the other columns need to have those as column names. 

Move the `user_fields.rake` file into `/var/www/discourse/lib/tasks` inside the container (perhaps by putting it in `/var/discourse/shared/standalone` outside the container and then moving it from inside the container).

You can then

       rake user_fields:import_csv[csv-filename.csv]

And the fields from the CSV will be updated or created in the user records.

This script is available free and is unsupported. If you would like to pay for support, feel free to contact me.

