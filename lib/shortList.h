#ifndef _SHORTLIST_H_GUARD_
#define _SHORTLIST_H_GUARD_ 1
#include "json.h"
#define SHORTV_LENGTH 32


// some of this code can be improved - like short erase
class ShortList {
private:
	short data[SHORTV_LENGTH];
	short top;
public:
	ShortList(){ top = 0; }
	ShortList(const Json::Value root) {
		for (short i = 0;i<root.size();++i)
			data[i] = root[i].asInt();
		top = root.size();
	}

	typedef short* iterator;

	void push_back(const short& ele){data[top++]=ele;}
	bool empty() const {return top==0;}
	short size() const {return top;}
	
	void clear() {top=0;}
	
	iterator begin() {return data;}
	iterator end() {return data+top;}
	iterator erase(iterator iter) {
		for (short i=0;i< (end()-iter)-1;++i)
			iter[i] = iter[i + 1];
		top-=1;
		return iter;
	}

	// op
	short operator[](const short index) const { return data[index]; }
	operator Json::Value() {
		Json::Value root;
		for (short i = 0; i < top;++i)
			root.append(data[i]);
		return root;
	}
};

#endif
