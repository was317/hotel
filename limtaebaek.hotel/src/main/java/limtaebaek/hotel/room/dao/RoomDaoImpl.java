package limtaebaek.hotel.room.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import limtaebaek.hotel.room.dao.mapper.RoomMapper;
import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.domain.Room;

@Repository
public class RoomDaoImpl implements RoomDao{
	@Autowired private RoomMapper mapper = null;
	
	@Override
	public int addRoom(Room room) {
		
		return mapper.addRoom(room);
	}

	@Override
	public List<Room> getRooms() {
		return mapper.getRooms();
	}

	@Override
	public int delRoom(int roomNum) {
		return mapper.delRoom(roomNum);
	}

	@Override
	public Room getRoom(int roomNum) {
		return mapper.getRoom(roomNum);
	}

	@Override
	public int addOption(Option option) {
		return mapper.addOption(option);
	}

	@Override
	public int updateRoom(Room room) {
		return mapper.updateRoom(room);
	}



	

	
}
