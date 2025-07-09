# Koyama Sushi

Aplicación móvil de menú para un negocio local de sushi

## Estructura de la Base de Datos

```typescript
type Category = {
    name: string;
    description?: string;
    imageUrl: string;          // transparent-background image that represents the whole category
    defaultDishImage: string;  // image used to render whenever a dish of this category doesn't render its image properly
};

type _DishWithVariations = {
    name: string;
    description?: string;
    tags?: string[];
    category: Reference;
    imageUrl?: string;

    type: "dish-with-variations";
    variations: Subcollection<{
        name: string;
        description?: string;
        tags?: string[];
        imageUrl?: string;
        price: number;
    }>;
};

type _RegularDish = {
    name: string;
    description?: string;
    tags?: string[];
    category: Reference;
    imageUrl?: string;

    type: "regular-dish";
    price: number;
};

type Dish = _RegularDish | _DishWithVariations;
```


