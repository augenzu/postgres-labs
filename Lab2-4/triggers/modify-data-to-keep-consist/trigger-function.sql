drop function if exists keep_valid_place_id cascade;

create function keep_valid_place_id() returns trigger as $keep_valid_place_id$
    begin
        -- Проверяем, есть ли место с тем id, с которым мы пытаемся добавить/обновить запись, в таблице place
        -- Если нет, выдаем ошибку и:
        if (not exists (select 1 from place where place_id = new.place_id)) then 
            -- при добавлении заменяем place_id на NULL
            if (TG_OP = 'INSERT') then
                raise warning 'Place with id % doesn`t exist. Attribute ''place_id'' of fest ''%'' will be set to NULL.', 
                    new.place_id, new.fest_name;
                new.place_id := null;
            -- при обновлении оставляем place_id прежним
            elsif (TG_OP = 'UPDATE') then
                raise warning 'Place with id % doesn`t exist. Attribute ''place_id'' of fest ''%'' will remain unchanged.', 
                    new.place_id, old.fest_name;
                new.place_id := old.place_id;
            end if;
        end if;
        return new;
    end;
$keep_valid_place_id$ language plpgsql;

create trigger keep_valid_place_id before insert or update on fest
    for each row execute function keep_valid_place_id();
