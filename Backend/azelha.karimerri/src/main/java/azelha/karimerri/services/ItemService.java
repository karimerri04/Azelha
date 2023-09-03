package azelha.karimerri.services;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import azelha.karimerri.commons.AzelhaLogger;
import azelha.karimerri.entites.Item;
import azelha.karimerri.repos.ItemRepository;

@Service
@Transactional
public class ItemService {

	private static final AzelhaLogger logger = AzelhaLogger.getLogger(ItemService.class);

	@Autowired
	ItemRepository orderItemRepository;

	public Set<Item> createOrderItem(Set<Item> orderItems) {
		Set<Item> persistenceItems = new HashSet<Item>();
		for (Item item : orderItems) {
			final Item savedOrderItem = orderItemRepository.save(item);
			logger.info("New OrderItem created. OrderItem Number ", savedOrderItem.getItemName());
			persistenceItems.add(savedOrderItem);
		}
		return persistenceItems;
	}

	public List<Item> getAllOrderItems() {
		return orderItemRepository.findAll();
	}

	public Item getOrderItemByProductId(Integer id) {
		return orderItemRepository.findOrderItemByProductId(id);
	}

}
