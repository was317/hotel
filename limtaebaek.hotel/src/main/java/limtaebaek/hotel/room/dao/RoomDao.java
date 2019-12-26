package limtaebaek.hotel.room.dao;

import java.util.List;

import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.domain.Room;


public interface RoomDao {
	List<Room> getRooms();
	Room getRoom(int roomNum);
	int addRoom(Room room);
	int addOption(Option option);
	int delRoom(int roomNum);
	int updateRoom(Room room);
}
