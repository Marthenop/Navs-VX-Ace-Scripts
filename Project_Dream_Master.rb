class Window_MenuStatus < Window_Selectable
	def window_height
		Graphics.height - 260 #This is the lowest I can go before the graphics bug out
	end
	
	def item_height
		Graphics.height - (standard_padding + 280) #And this is needed due to the previous change.
	end	
end	

class Window_Gold < Window_Base
	def refresh
		contents.clear
		draw_currency_value(currency_unit, value, 4, 0, contents.width - 8) #The first two options are swapped as we're using usd for the currency
	end	
end

class Window_MenuCommand < Window_Command #This is just overwriting useless menu commands that we don't need.
	def add_main_commands
		add_command(Vocab::item, :item, main_commands_enabled)
		add_command(Vocab::status, :status, main_commands_enabled)
	end
	
	def add_formation_command	
	end
	
	def add_save_command
	end
	
	def add_game_end_command
	end
end

class Scene_Item < Scene_ItemBase #This entire class is to skip the category selection, as we don't need it.
	def start
		super
		create_help_window
		create_item_window
	end
	
	def create_category_window
		@category_window = Window_ItemCategory.new
		@category_window.viewport = @viewport
		@category_window.help_window = @help_window
		@category_window.y = @help_window.height
		@category_window.height = 0
	end
	
	def create_item_window
		@item_window = Window_ItemList.new(0,@help_window.height,Graphics.width,(Graphics.height - @help_window.height))
		@item_window.set_handler(:ok, method(:on_item_ok))
		@item_window.set_handler(:cancel, method(:on_item_cancel))
		@item_window.help_window = @help_window
		@item_window.category = :item
		@item_window.viewport = @viewport
		@item_window.activate
		@item_window.select_last
		@description.refresh(@item_window.item) if @description
	end
	
	def on_item_cancel
		return_scene
	end	
end
	
class Window_base < Window #This class and the next one are used to make the menu transitions faster.
	def update_open
		self.openness += 255
		@opening = false if open?
	end
	
	def update_close
		self.openness += 255
		@closing = false if close?
	end

end

class Scene_Menu < Scene_MenuBase
	
	def transition_speed
		return 0
	end
	
	def terminate
		super
		Graphics.transition(0)
	end
end