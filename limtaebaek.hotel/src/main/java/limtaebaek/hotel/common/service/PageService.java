package limtaebaek.hotel.common.service;

import limtaebaek.hotel.common.domain.Page;

public interface PageService {
	Page paging(int nowPage, int dataSize);
}
