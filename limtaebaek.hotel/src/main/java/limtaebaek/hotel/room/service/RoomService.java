package limtaebaek.hotel.room.service;

import java.util.List;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.domain.Room;

public interface RoomService {
	List<Room> getRooms();
	Room getRoom(int roomNum);
	//boolean join(Room room);
	boolean join(Room room, List<Option> options);
	
	boolean delRoom(int roomNum);
	boolean updateRoom(Room room);
	String getOption(Room room);
}
