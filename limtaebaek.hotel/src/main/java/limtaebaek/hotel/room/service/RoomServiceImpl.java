package limtaebaek.hotel.room.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import limtaebaek.hotel.booking.domain.Booking;
import limtaebaek.hotel.room.dao.RoomDao;
import limtaebaek.hotel.room.domain.Option;
import limtaebaek.hotel.room.domain.Room;

@Service
public class RoomServiceImpl implements RoomService{
	@Autowired private RoomDao roomDao;
	
/*	@Transactional
	public boolean join(Room room) {
		return roomDao.addRoom(room)>0;
	}*/

	@Transactional
	public List<Room> getRooms() {
		return roomDao.getRooms();
	}

	@Override
	public boolean delRoom(int roomNum) {
		return roomDao.delRoom(roomNum)>0;
	}

	@Override
	public Room getRoom(int roomNum) {
		return roomDao.getRoom(roomNum);
	}

	@Override
	public boolean join(Room room, List<Option> options) {
		int length = 1 + options.size();
		int a =  roomDao.addRoom(room);
		int cnt = 0;
		for(Option option:options){
			cnt += roomDao.addOption(option);
	
		}
		return (a + cnt) > (length -1 );
	
	}

	@Override
	public boolean updateRoom(Room room) {
		return roomDao.updateRoom(room)>0;
	}

	@Override
	public String getOption(Room room) {
		String roomOption="";
		int roomNum = room.getRoomNum();
		List<Option> list = getRoom(roomNum).getOptions();
		String[] option = {"조식", "스파", "야외수영장", "엑스트라베드"};
		for(int i=0; i<list.size(); i++){
			if(list.get(i).getOptNo() == 0) continue;
			else
				roomOption = roomOption + option[list.get(i).getOptNo() - 1] + " ";
			}
		
		return roomOption;
	}


}
