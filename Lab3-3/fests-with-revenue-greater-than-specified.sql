create or replace function fsts_wth_rvn_gt_spcfd(min_revenue int) returns setof fest_info as $$
begin
    return query execute
        format('select * from fest_info where total_revenue > $1') using min_revenue;
    if not found then
        raise exception 'There are no fests with total revenue greater than %.', min_revenue;
    end if;
    return;
end;
$$ language plpgsql;


select * from fsts_wth_rvn_gt_spcfd(1750000);
