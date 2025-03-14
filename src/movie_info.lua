-- Load files
local movies, load_error = assert(SMODS.load_file("moviedata/movies.lua"))()
if load_error then
  sendDebugMessage ("The error is: "..load_error)
end

local actors, load_error = assert(SMODS.load_file("moviedata/actors.lua"))()
if load_error then
  sendDebugMessage ("The error is: "..load_error)
end

-- iterate through the movies
for j, var in pairs(movies) do
    local id = string.sub(j, 4)
    for i, v in ipairs(Kino.jokers) do
      if SMODS.Centers[v] then
      end
      if SMODS.Centers[v].kino_joker and tostring(SMODS.Centers[v].kino_joker.id) == id then
          SMODS.Centers[v].kino_joker.budget = var.budget
          SMODS.Centers[v].kino_joker.box_office = var.box_office
          SMODS.Centers[v].kino_joker.release_date = var.release_date
          SMODS.Centers[v].kino_joker.runtime = var.runtime
          SMODS.Centers[v].kino_joker.country_of_origin = var.country_of_origin
          SMODS.Centers[v].kino_joker.original_language = var.original_language
          SMODS.Centers[v].kino_joker.critic_score = var.critic_score
          SMODS.Centers[v].kino_joker.audience_score = var.audience_score
          SMODS.Centers[v].kino_joker.directors = var.directors
          SMODS.Centers[v].kino_joker.cast = var.cast
      end
    end
end

function is_genre(joker, genre)
  if joker.config.center.k_genre then
      for i = 1, #joker.config.center.k_genre do
          if genre == joker.config.center.k_genre[i] then
              return true
          end
      end
  end
  return false
end

function Card:get_release(card)
  if card.config.center.kino_joker then
      local _joker = card.config.center.kino_joker

      local _year = tonumber(string.sub(_joker.release_date, 1, 4))
      local _month = tonumber(string.sub(_joker.release_date, 6, 7))
      local _day = tonumber(string.sub(_joker.release_date, 9, 10))

      return {_year, _month, _day}
  end

  return false
end