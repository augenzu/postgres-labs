-- Если не установить этот триггер, то можно будет беспроблемно выполнить 
-- 2й запрос из check-query.sql, хотя результат его выполнения нарушает целостность бд

drop function forbid_changing_band_id cascade;

create function forbid_changing_band_id() returns trigger as $forbid_changing_band_id$
    begin
        -- Проверяем, совпадает ли новое значение band_id со старым (непонятно, зачем тогда обновлять, но мало ли).
        -- Если старое и новое значения различаются, откатываем транзакцию 
        -- (иначе поломаются внешние ключи в таблицах performance, band_genre и musician)
        if old.band_id != new.band_id then
            raise exception 'Attribute ''band_id'' of band ''%'' cannot be changed!', old.band_name;
        end if;
        return new;
    end;
$forbid_changing_band_id$ language plpgsql;

create trigger forbid_changing_band_id before update on band
    for each row execute function forbid_changing_band_id();
