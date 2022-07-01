/* load orders.csv */
ordersCSV = LOAD '/user/maria_dev/diplomacy/orders.csv'  USING PigStorage(',')AS
	(game_id:chararray,
    unit_id:chararray,
    unit_order:chararray,
    location:chararray,
    target:chararray,
    target_dest:chararray,
    success:chararray,
    reason:chararray,
    turn_num:chararray);

/*Part 2: Group by location with target Holland. */
Filtered_list = Filter ordersCSV BY target == '"Holland"';
groupedBy_list = GROUP Filtered_list BY (location, target);

/*Part 3: Count how many times Holland was the target from that location. */
Counted_list = FOREACH groupedBy_list GENERATE group, COUNT(Filtered_list);

/*Part 1: a alphabetic list from all locations from the orders.csv. */
alphabetic_list = ORDER Counted_list BY $0 ASC;

DUMP alphabetic_list;
